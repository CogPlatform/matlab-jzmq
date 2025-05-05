classdef ZPoller < handle
    properties ( Access = private )
        pollerPointer
    end

    methods
        %TODO:
        function obj = ZPoller(context)
            obj.pollerPointer = org.zeromq.ZPoller(context);
        end

        %TODO:
        function register(obj, socket, events)
            arguments
                obj
                socket (1, 1)
                events (1, 1) jzmq.PollEvent
            end

            obj.pollerPointer.register(socket, events);
        end

        %TODO:
        function events = poll(obj, timeout)
            arguments (Input)
                obj (1, 1) ZPoller
                timeout (1, 1) double
            end
            arguments (Output)
                events (1, 1) double
            end

            events = obj.pollerPointer.poll(timeout);
        end
    end
end