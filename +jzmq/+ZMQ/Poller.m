classdef Poller < handle
	%Poller  Encapsulates a ZeroMQ poller using JeroMQ ZMQ.Poller.
	properties ( GetAccess = public, SetAccess = private )
		pointer % org.zeromq.ZMQ.Poller
		socket
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

			obj.pointer = pointer;
		end

		function register(obj, socket, event)
			%register  Register a Socket for polling on the specified events.
			%   register(obj, socket, event) Register a Socket for polling on the specified event.
			%
			%   Inputs:
			%       obj     - A jzmq.ZMQ.Poller object.
			%       socket  - The Socket we are registering.
			%       events  - A mask composed by BITORing POLLIN, POLLOUT and POLLERR.

			arguments
				obj
				socket (1, 1) jzmq.ZMQ.Socket
				event (1, 1) int32 = 1
			end

			if ~isa(obj.socket, 'jzmq.ZMQ.Socket')
				obj.socket = socket;
			end

			obj.pointer.register(obj.socket.pointer, int32(event));
		end

		function unregister(obj, socket)
			%unregister  Unregister a Socket.
			%   unregister(obj, socket) Unregister a Socket for polling.
			%
			%   Inputs:
			%       obj     - A jzmq.ZMQ.Poller object.
			%       socket  - The Socket we are registering.
			
			arguments
				obj
				socket (1, 1) jzmq.ZMQ.Socket
			end

			obj.pointer.unregister(socket.pointer);
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
				tout (1, 1) double = 0
			end
			arguments (Output)
				events (1, 1) double
			end

			events = obj.pointer.poll(tout);
		end

		function result = pollin(obj, time)
			arguments (Input)
				obj
				time (1, 1) double = 0
			end
			arguments (Output)
				result (1, 1) logical
			end
			obj.register(obj.socket, jzmq.ZMQ.PollerEvent.POLLIN);
			result = obj.poll(time);
		end

		function result = pollout(obj, time)
			arguments (Input)
				obj
				time (1, 1) double = 0
			end
			arguments (Output)
				result (1, 1) logical
			end
			obj.register(obj.socket, jzmq.ZMQ.PollerEvent.POLLOUT);
			result = obj.poll(time);
		end

		function result = pollerr(obj, time)
			arguments (Input)
				obj
				time (1, 1) double = 0
			end
			arguments (Output)
				result (1, 1) logical
			end
			obj.register(obj.socket, jzmq.ZMQ.PollerEvent.POLLERR);
			result = obj.poll(time);
		end

		function socket = getSocket(obj)
			
			socket = obj.pointer.getSocket();
			
		end

		function close(obj)
			if ~isempty(obj.socket) && isa(obj.socket,'jzmq.ZMQ.Socket')
				try obj.unregister(obj.socket); end %#ok<*TRYNC>
			end
			obj.socket = [];
			obj.pointer.close();
		end
		function delete(obj)
			close(obj);
		end

	end
end