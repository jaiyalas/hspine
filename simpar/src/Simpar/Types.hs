module Simpar.Types where
--
-- | (universal) data union
data Magic
    = MagicStruct StructEntity
    | MagicFunction FunctionEntity
    | MagicConstant ConstantEntity
    deriving (Show, Eq)
--
deMagic' :: [Magic]
        -> ([StructEntity],[FunctionEntity],[ConstantEntity])
        -> ([StructEntity],[FunctionEntity],[ConstantEntity])
deMagic' [] res = res
deMagic' ((MagicStruct   x):xs) (ss,fs,cs) = deMagic' xs (ss ++ [x], fs, cs)
deMagic' ((MagicFunction x):xs) (ss,fs,cs) = deMagic' xs (ss, fs ++ [x], cs)
deMagic' ((MagicConstant x):xs) (ss,fs,cs) = deMagic' xs (ss, fs, cs ++ [x])
--
deMagic :: [Magic]
        -> ([StructEntity],[FunctionEntity],[ConstantEntity])
deMagic xs = deMagic' xs ([],[],[])
--
-- | constant
data ConstantEntity = ConstantEntity
    { ctype :: FTypEntity
    , cname :: String
    } deriving (Show, Eq)
--
-- | foreign types
data FTyp
    = FTInt
    | FTFloat
    | FTShort
    | FTChars
    | FTUInt
    | FTUShort
    | FTVoid
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
