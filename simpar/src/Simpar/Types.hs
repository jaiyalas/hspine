module Simpar.Types where
--
-- | foreign types
data FTyp
    = FTInt
    | FTFloat
    | FTVoid
    | FTChars
    | FTOther String
    deriving (Eq, Show)
--
-- | foreign Types Entity (type together with amount of pointers)
data FTypEntity = FTypEntity
    { ptrCounter :: Int
    , typeBody :: FTyp
    } deriving (Eq, Show)
--
-- | struct fields
data FieldEntity = FieldEntity
    { fieldName :: String
    , fieldType :: FTypEntity
    , fieldComm :: Maybe String
    } deriving (Eq, Show)
--
-- | struct
data StructEntity = StructEntity
    { sname   :: String
    , sfields :: [FieldEntity]
    } deriving (Eq, Show)
--
-- | function
data FunctionEntity = FunctionEntity
    { fname :: String
    , rttype :: FTypEntity
    , argTypes :: [ArgEntity]
    , fcomm :: Maybe String
    } deriving (Show, Eq)
--
-- | type for function arguments
data ArgEntity = ArgEntity
    { argName :: String
    , atgType :: FTypEntity
    } deriving (Show, Eq)
