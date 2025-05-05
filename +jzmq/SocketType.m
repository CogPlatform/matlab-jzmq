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
            switch obj
                case jzmq.SocketType.CHANNEL
                    javaType = org.zeromq.SocketType.CHANNEL;
                case jzmq.SocketType.CLIENT
                    javaType = org.zeromq.SocketType.CLIENT;
                case jzmq.SocketType.DEALER
                    javaType = org.zeromq.SocketType.DEALER;
                case jzmq.SocketType.DISH
                    javaType = org.zeromq.SocketType.DISH;
                case jzmq.SocketType.GATHER
                    javaType = org.zeromq.SocketType.GATHER;
                case jzmq.SocketType.PAIR
                    javaType = org.zeromq.SocketType.PAIR;
                case jzmq.SocketType.PEER
                    javaType = org.zeromq.SocketType.PEER;
                case jzmq.SocketType.PUB
                    javaType = org.zeromq.SocketType.PUB;
                case jzmq.SocketType.PULL
                    javaType = org.zeromq.SocketType.PULL;
                case jzmq.SocketType.PUSH
                    javaType = org.zeromq.SocketType.PUSH;
                case jzmq.SocketType.RADIO
                    javaType = org.zeromq.SocketType.RADIO;
                case jzmq.SocketType.RAW
                    javaType = org.zeromq.SocketType.RAW;
                case jzmq.SocketType.REP
                    javaType = org.zeromq.SocketType.REP;
                case jzmq.SocketType.REQ
                    javaType = org.zeromq.SocketType.REQ;
                case jzmq.SocketType.ROUTER
                    javaType = org.zeromq.SocketType.ROUTER;
                case jzmq.SocketType.SCATTER
                    javaType = org.zeromq.SocketType.SCATTER;
                case jzmq.SocketType.SERVER
                    javaType = org.zeromq.SocketType.SERVER;
                case jzmq.SocketType.STREAM
                    javaType = org.zeromq.SocketType.STREAM;
                case jzmq.SocketType.SUB
                    javaType = org.zeromq.SocketType.SUB;
                case jzmq.SocketType.XPUB
                    javaType = org.zeromq.SocketType.XPUB;
                case jzmq.SocketType.XSUB
                    javaType = org.zeromq.SocketType.XSUB;
            end
        end
    end
end