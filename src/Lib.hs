module Lib where

import Data.Text ( Text )
import Data.ByteString ( ByteString )

data ClientAction = Quit | Message Text



serialize :: ClientAction -> ByteString
serialize = undefined

deserialize :: ByteString -> Either String ClientAction
deserialize = undefined
