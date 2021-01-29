import Network.Simple.TCP
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Data.Text.Encoding as T

main :: IO ()
main = do
    putStrLn "Starting server"
    serve (Host "localhost") "8080" serverBody

serverBody :: (Socket, SockAddr) -> IO ()
serverBody (socket, sockAddr) = do
    putStrLn ("Hello, client " ++ show sockAddr)
    serverLoop socket
    putStrLn ("Bye, client " ++ show sockAddr)

serverLoop :: Socket -> IO ()
serverLoop socket = do
    raw <- recv socket 1000
    let input = case raw of
            Nothing -> Left "Client disconnected"
            Just bs -> Right (T.decodeUtf8 bs)

    case input of
        Left err -> putStrLn ("Error: " ++ err)
        Right msg
            | msg == T.pack ":quit"
                -> putStrLn "Client says goodbye"
            | otherwise -> do
                T.putStrLn msg
                serverLoop socket
