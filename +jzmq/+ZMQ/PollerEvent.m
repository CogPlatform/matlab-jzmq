classdef PollerEvent < int32
    %PollerEvent  Defines polling events for JeroMQ ZMQ.Poller
    %   The PollerEvent enumeration specifies the types of events that can
    %   be monitored by a ZMQ.Poller object.
    %
    %   Enumeration Members:
    %       POLLERR  - For standard sockets, this flag is passed through
    %                  ZMQ.poll(Selector, zmq.poll.PollItem[], long) to
    %                  the underlying poll() system call and generally means
    %                  that some sort of error condition is present on the
    %                  socket specified by fd.
    %       POLLIN   - For ØMQ sockets, at least one message may be received
    %                  from the socket without blocking.
    %       POLLOUT  - For ØMQ sockets, at least one message may be sent to 
    %                  the socket without blocking.

    % TODO: Since org.zeromq.ZMQ.Poller is a Java nested class, its fields 
    % cannot be accessed directly, so fixed values are used.
    %
    % See also: https://www.javadoc.io/static/org.zeromq/jeromq/0.6.0/constant-values.html#org.zeromq.ZMQ.Poller.POLLERR

    enumeration
        POLLERR   (4)
        POLLIN    (1)
        POLLOUT   (2)
    end
end