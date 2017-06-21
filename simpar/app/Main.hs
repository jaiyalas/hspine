module Main where
--
import Lib
--
import Text.Parsec
--
main :: IO ()
main = do
    -- let x = parse expressionParser "" "(1+(3-4))"
    let x = parse (optionMaybe (many $ oneOf "0123456789")) "" "123"
    putStrLn $ show x
    let y = parse (optionMaybe (many $ oneOf "0123456789")) "" "abc"
    putStrLn $ show y
    let z = parse (optionMaybe (many1 $ oneOf "0123456789")) "" "abc"
    putStrLn $ show z
--
type TNumber = Int
--
data TOperator
    = TAdd
    | TSubtract
    deriving (Eq, Ord, Show)
--
data TExpression
    = TNode (TExpression) TOperator (TExpression)
    | TTerminal TNumber
    deriving (Show)
--
numberParser :: Parsec String st TNumber
numberParser = read <$> (many $ oneOf "0123456789")
--
operatorParser :: Parsec String st TOperator
operatorParser = chooseOp <$> (oneOf "+-")
                   where chooseOp '+' = TAdd
                         chooseOp '-' = TSubtract
--
expressionParser :: Parsec String st TExpression
expressionParser = (between (char '(') (char ')') binaryExpressionParser) <|>
                   (TTerminal <$> numberParser)
--
binaryExpressionParser :: Parsec String st TExpression
binaryExpressionParser = TNode <$> expressionParser <*> operatorParser <*> expressionParser
--




data StructEntity = StructEntity deriving (Eq, Show)
data StructName = StructName String deriving (Eq, Show)
data StructFields = StructFields [FieldEntity] deriving (Eq, Show)
--
pStructEntity :: Parsec String st StructEntity
pStructEntity = undefined
-- char '{'
-- many1 pStructField
--
--
pStructName :: Parsec String st StructName
pStructName = do
    string "typedef"
    spaces
    string "struct"
    spaces
    s <- (many $ letter)
    return (StructName s)
--
pStructFields :: Parsec String st StructFields
pStructFields = do
    es <- many1 pFieldEntity
    return (StructFields es)
--
data FieldEntity = FieldEntity
    { fieldName :: String
    , fieldType :: FTyp
    , fieldComm :: Maybe String
    } deriving (Eq, Show)
--
-- float* const frames; /* time, mix, bendDirection, ... */
pFieldEntity :: Parsec String st FieldEntity
pFieldEntity = do
    spaces
    ty <- pFTyp
    spaces
    _ <- optionMaybe (string "const")
    spaces
    name <- anyToken
    spaces
    char ';'
    spaces
    mcomm <- optionMaybe (between (symbol "/* ") (symbol " */") (many1 letter))
    spaces
    return $ FieldEntity name ty mcomm
--
data FTypEntity = FTypEntity
    { ptrCounter :: Int
    , typeBody :: }
    deriving (Eq, Show)
--
data FTyp
    = FTInt
    | FTFloat
    | FTVoid
    | FTOther String
    deriving (Eq, Show)
--
pFTyp :: Parsec String st FTyp
pFTyp = choice [pFTInt, pFTFloat, pFTVoid, pFTOther]
--
pFTInt :: Parsec String st FTyp
pFTInt = undefined
--
pFTFloat :: Parsec String st FTyp
pFTFloat = undefined
--
pFTVoid :: Parsec String st FTyp
pFTVoid = undefined
--
pFTOther :: Parsec String st FTyp
pFTOther = undefined -- String

--

--
str1 :: String
str1 = "typedef struct spIkConstraintTimeline "

-- "typedef struct spIkConstraintTimeline {
-- 	spCurveTimeline super;
-- 	int const framesCount;
-- 	float* const frames; /* time, mix, bendDirection, ... */
-- 	int ikConstraintIndex;
--
-- #ifdef __cplusplus
-- 	spIkConstraintTimeline() :
-- 		super(),
-- 		framesCount(0),
-- 		frames(0),
-- 		ikConstraintIndex(0) {
-- 	}
-- #endif
-- } spIkConstraintTimeline;"
