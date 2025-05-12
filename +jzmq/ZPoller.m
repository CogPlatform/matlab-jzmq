classdef ZPoller < handle
    properties ( GetAccess = public, SetAccess = private )
        pointer
        socket
    end

    methods
        %TODO:
        function obj = ZPoller(context)
            if isa(context, 'jzmq.ZContext')
                context = context.pointer;
            end
            obj.pointer = org.zeromq.ZPoller(context);
        end

        %TODO:
        function register(obj, socket, events)
            arguments
                obj
                socket (1, 1)
                events (1, 1)
            end
            obj.pointer.register(socket, events);
            obj.socket = socket;
        end

        function unregister(obj, socket)
            arguments
                obj
                socket (1, 1)
            end
            if isempty(socket); socket = obj.socket; end
            obj.pointer.unregister(socket);
            obj.socket = [];
        end


        function events = poll(obj, timeout)
            arguments (Input)
                obj (1, 1) jzmq.ZPoller
                timeout (1, 1) double = 0
            end
            arguments (Output)
                events (1, 1) double
            end

            events = obj.pointer.poll(timeout);
        end

        function result = isReadable(obj, socket)
            arguments (Input)
                obj (1, 1) jzmq.ZPoller
                socket = []
            end
            arguments (Output)
                result (1, 1) logical
            end
            if isempty(socket); socket = obj.socket; end
            result = obj.pointer.isReadable(socket);
        end

        function result = isWritable(obj, socket)
            arguments (Input)
                obj (1, 1) jzmq.ZPoller
                socket = []
            end
            arguments (Output)
                result (1, 1) logical
            end
            if isempty(socket); socket = obj.socket; end
            result = obj.pointer.isWritable(socket);
        end

        function result = isError(obj, socket)
            arguments (Input)
                obj (1, 1) jzmq.ZPoller
                socket = []
            end
            arguments (Output)
                result (1, 1) logical
            end
            if isempty(socket); socket = obj.socket; end
            result = obj.pointer.isError(socket);
        end

    end
end