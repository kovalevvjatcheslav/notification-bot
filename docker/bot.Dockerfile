FROM tor:latest

COPY .stack-work/dist/x86_64-linux-tinfo6/Cabal-3.0.1.0/build/notification-bot/notification-bot notification-bot

ENTRYPOINT service tor start && proxychains4 ./notification-bot