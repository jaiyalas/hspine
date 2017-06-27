module Types where
--
data FTyp
    = FTInt
    | FTFloat
    | FTVoid
    | FTChars
    | FTOther String
    deriving (Eq, Show)
--
data FTypEntity = FTypEntity
    { ptrCounter :: Int
    , typeBody :: FTyp
    } deriving (Eq, Show)
--
data FieldEntity = FieldEntity
    { fieldName :: String
    , fieldType :: FTypEntity
    , fieldComm :: Maybe String
    } deriving (Eq, Show)
--
data StructEntity = StructEntity
    { sname   :: String
    , sfields :: [FieldEntity]
    } deriving (Eq, Show)
--
data FunctionEntity = FunctionEntity
    { fname :: String
    , rttype :: FTypEntity
    , argTypes :: [FTypEntity]
    , fcomm :: Maybe String
    } deriving (Show, Eq)
-- 
