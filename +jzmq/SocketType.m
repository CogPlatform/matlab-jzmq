classdef SocketType
    enumeration
        CHANNEL
        CLIENT
        DEALER
        DISH
        GATHER
        PAIR
        PEER
        PUB
        PULL
        PUSH
        RADIO
        RAW
        REP
        REQ
        ROUTER
        SCATTER
        SERVER
        STREAM
        SUB
        XPUB
        XSUB
    end

    methods
        function javaType = toJava(obj)
			javaType = org.zeromq.SocketType.(string(obj));
        end
    end
end