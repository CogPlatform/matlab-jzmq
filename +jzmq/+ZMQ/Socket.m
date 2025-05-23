classdef Socket < handle
	%Socket  Encapsulates a ZeroMQ socket using JeroMQ ZMQ.Socket.
	
	properties (GetAccess = public, SetAccess = private)
		pointer
		% status of bind
		isBind = false
		% status of connect
		isConnect = false
		% object uuid
		uuid
	end
	
	methods
		% ===================================================================
		function obj = Socket(socket)
		%Socket  Constructs a ZMQ.Socket object.
		%   obj = Socket(pointer) creates a ZMQ.Socket object
		%
		%   Inputs:
		%       pointer - ZMQ.Socket object pointer.
		%
		%   Outputs:
		%       obj     - A ZMQ.Socket object.
		% ===================================================================
			obj.pointer = socket;
			obj.uuid = num2str(dec2hex(floor((now - floor(now))*1e10)));
		end
		
		% ===================================================================
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
		% ===================================================================
			arguments (Input)
				obj
				addr (1, :) string
			end

			arguments (Output)
				result (1, 1) logical
			end

			result = obj.pointer.bind(addr);

			obj.isBind = result;
			
			if ~result
				warning('jzmq.ZMQ.Socket:bind','Cannot bind!')
			end
		end

		% ===================================================================
		function result = unbind(obj, addr)
		%unbind  Unbinds the socket from a network endpoint.
		%   unbind(obj, addr) unbinds the JeroMQ socket from the specified
		%   endpoint.
		%
		%   Inputs:
		%       obj      - A Socket object.
		%       addr - The network endpoint to unbind from.
		% ===================================================================
			arguments (Input)
				obj
				addr (1, :) string
			end

			arguments (Output)
				result (1, 1) logical
			end

			% Unbind the JeroMQ ZSocket
			result = obj.pointer.unbind(addr);

			obj.isBind = ~result;

		end

		% ===================================================================
		function result = connect(obj, addr)
		%connect  Connects the socket to a network endpoint.
		%   connect(obj, addr) connects the JeroMQ socket to the specified
		%   endpoint.
		%
		%   Inputs:
		%       obj      - A Socket object.
		%       addr - The network endpoint to connect to (e.g., 'tcp://localhost:5555').
		% ===================================================================
			arguments (Input)
				obj
				addr (1, :) string
			end

			arguments (Output)
				result (1, 1) logical
			end
			
			result = obj.pointer.connect(addr);

			obj.isConnect = result;

			if ~result
				warning('jzmq.ZMQ.Socket:connect','Cannot connect!')
			end
		end

		% ===================================================================
		function result = disconnect(obj, addr)
		%connect  Disconnects the socket to a network endpoint.
		%   disconnect(obj, addr) disconnects the JeroMQ socket 
		%
		%   Inputs:
		%       obj      - A Socket object.
		%       addr - The network endpoint to connect to (e.g., 'tcp://localhost:5555').
		% ===================================================================
			arguments (Input)
				obj
				addr (1, :) string {mustBeText}
			end

			arguments (Output)
				result (1, 1) logical
			end

			result = obj.pointer.disconnect(addr);

			obj.isConnect = ~result;

		end

		% ===================================================================
		function data = recv(obj)
		%recv  Receives a message.
		%   recv(obj) Receives a message.
		%
		%   Inputs:
		%       obj  - A ZMQ.Socket object.
		%
		%   Outputs:
		%       data - the message received, as an array of bytes; null on error.
		% ===================================================================
			arguments (Output)
				data (1, :) uint8
			end
			
			data = obj.pointer.recv();
		end

		
		% ===================================================================
		function result = send(obj, data, flags)
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
		% ===================================================================
			arguments (Input)
				obj
				data (1, :) uint8 {mustBeNonempty}
				flags = []
			end

			arguments (Output)
				result (1, 1) logical
			end

			if isempty(flags) && isinteger(flags)
				result = obj.pointer.send(data, flags);
			else
				result = obj.pointer.send(data);
			end
		end

		% ===================================================================
		function result = hasReceiveMore(obj)
		% ===================================================================
			arguments (Output)
				result (1, 1) logical
			end

			result = obj.pointer.hasReceiveMore();
		end
		
		% ===================================================================
		function close(obj)
		% close This is an explicit "destructor". It can be called to ensure the
		% corresponding 0MQ Socket has been disposed of. If the socket was
		% created from a org.zeromq.ZContext, it will remove the reference to
		% this socket from it.
		%   close(obj)
		%
		%   Inputs:
		%       obj - A ZMQ.Socket object.
		% ===================================================================
			obj.isBind = false;
			obj.isConnect = false;
			obj.pointer.close();
		end
		% ===================================================================
		function delete(obj)
		% ===================================================================
			close(obj);
		end
	end
end