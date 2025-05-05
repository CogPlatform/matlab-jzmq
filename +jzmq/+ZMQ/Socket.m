classdef Socket < handle
    %Socket  Encapsulates a ZeroMQ socket using JeroMQ ZMQ.Socket.
    properties (GetAccess = public, SetAccess = private)
        pointer
    end
    
    methods
        function obj = Socket(socket)
            %Socket  Constructs a ZMQ.Socket object.
            %   obj = Socket(pointer) creates a ZMQ.Socket object
            %
            %   Inputs:
            %       pointer - ZMQ.Socket object pointer.
            %
            %   Outputs:
            %       obj     - A ZMQ.Socket object.
            obj.pointer = socket;
        end
        
        function result = bind(obj, addr)
            %Socket  Bind to network interface. Start listening for new connections.
            %   bing(obj, addr) Bind to network interface. Start listening for new connections.
            %
            %   Inputs:
            %       obj    - A ZMQ.Socket object.
            %       addr   - The endpoint to bind to.
            %
            %   Outputs:
            %       result - true if the socket was bound, otherwise false.
            arguments (Input)
                obj
                addr (1, :) char
            end

            arguments (Output)
                result (1, 1) logical
            end

            result = obj.pointer.bind(addr);
        end
        
        function data = recv(obj)
            %recv  Receives a message.
            %   recv(obj) Receives a message.
            %
            %   Inputs:
            %       obj  - A ZMQ.Socket object.
            %
            %   Outputs:
            %       data - the message received, as an array of bytes; null on error.
            arguments (Output)
                data (1, :) uint8
            end
            
            data = obj.pointer.recv();
        end
        
        function result = send(obj, data)
            %send Queues a message created from data, so it can be sent.
            %   send(obj, data, flags) Queues a message created from data, so it can be sent.
            %
            %   Inputs:
            %       obj    - A ZMQ.Socket object.
            %       data  - the data to send.
            %
            %   Outputs:
            %       result - true when it has been queued on the socket and ØMQ has assumed 
            %                responsibility for the message. This does not indicate that the message
            %                has been transmitted to the network.
            arguments (Input)
                obj
                data (1, :) uint8
            end
            arguments (Output)
                result (1, 1) logical
            end
            
            result = obj.pointer.send(data);
        end
        
        function close(obj)
            %close This is an explicit "destructor". It can be called to ensure the corresponding 0MQ Socket 
            %      has been disposed of. If the socket was created from a org.zeromq.ZContext, it will remove 
            %      the reference to this socket from it.
            %   close(obj)
            %
            %   Inputs:
            %       obj - A ZMQ.Socket object.

            obj.pointer.close();
        end
    end
end