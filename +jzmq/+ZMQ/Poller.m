classdef Poller < handle
	%Poller  Encapsulates a ZeroMQ poller using JeroMQ ZMQ.Poller.
    properties ( GetAccess = public, SetAccess = private )
        pollerPointer % org.zeromq.ZMQ.Poller
    end

    methods
        function obj = Poller(pointer)
            %Poller  Constructs a ZMQ.Poller object.
			%   obj = Poller(pointer) creates a ZMQ.Poller object
			%
			%   Inputs:
			%       pointer - ZMQ.Poller object pointer.
			%
			%   Outputs:
			%       obj     - A ZMQ.Poller object.

            obj.pollerPointer = pointer;
        end

        function register(obj, socket, event)
            %register  Register a Socket for polling on the specified events.
			%   rigister(obj, socket, events) Register a Socket for polling on the specified events.
			%
			%   Inputs:
			%       obj     - A jzmq.ZMQ.Poller object.
			%       socket  - The Socket we are registering.
			%       events  - A mask composed by XORing POLLIN, POLLOUT and POLLERR.

            arguments
                obj
                socket (1, 1) jzmq.ZMQ.Socket
                event (1, 1) jzmq.ZMQ.PollerEvent
            end

            obj.pollerPointer.register(socket.pointer, int32(event));
        end

        function events = poll(obj, tout)
            %poll  Issue a poll call, using the specified timeout value.
			%   poll(obj, timeout) Issue a poll call, using the specified timeout value.
			%
			%   Inputs:
			%       obj     - A jzmq.ZMQ.Poller object.
            %       tout - the timeout, as per zmq_poll (); if -1, it will block indefinitely 
            %                 until an event happens; if 0, it will return immediately; otherwise, 
            %                 it will wait for at most that many milliseconds/microseconds
			%
			%   Outputs:
			%       events  - How many objects where signaled by poll ()

            arguments (Input)
                obj
                tout (1, 1) double
            end
            arguments (Output)
                events (1, 1) double
            end

            events = obj.pollerPointer.poll(tout);
        end
    end
end