{-# LANGUAGE OverloadedStrings #-}

module Main where


import Network.Simple.TCP
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Data.Text.Encoding as T

import Lib

main :: IO ()
main = connect "localhost" "8080" clientBody

clientBody :: (Socket, sockAddr) -> IO ()
clientBody (socket, sockAddr) = do
    putStrLn "Client connected!"
    loop
  where
    loop = do
        putStrLn "Enter a message: "
        userInput <- T.getLine
        send socket (T.encodeUtf8 userInput)
        if userInput == ":quit"
            then pure ()
            else loop
