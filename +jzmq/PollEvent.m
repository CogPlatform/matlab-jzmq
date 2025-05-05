classdef PollEvent < int32
    %PollEvent  Defines polling events for JeroMQ ZPoller
    %   The PollEvent enumeration specifies the types of events that can
    %   be monitored by a ZPoller object.
    %
    % Since the implementation progress of ZPoller is currently uncertain, 
    % there is not enough documentation to describe these events.
    %
    % see also: https://github.com/zeromq/jeromq/blob/master/doc/pollers.md
    enumeration
        ERR       (org.zeromq.ZPoller.ERR)
        IN        (org.zeromq.ZPoller.IN)
        OUT       (org.zeromq.ZPoller.OUT)
        POLLERR   (org.zeromq.ZPoller.POLLERR)
        POLLIN    (org.zeromq.ZPoller.POLLIN)
        POLLOUT   (org.zeromq.ZPoller.POLLOUT)
        READABLE  (org.zeromq.ZPoller.READABLE)
        WRITABLE  (org.zeromq.ZPoller.WRITABLE)
    end
end

