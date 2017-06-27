module Main where
--
import Lib
--
import Text.Parsec
import Data.Char
import System.Environment (getArgs)
import System.IO
import Debug.Trace
--
main :: IO ()
main = do
    xs <- getArgs
    h1 <- openFile (head xs) ReadMode
    h2 <- openFile "output.hsc" WriteMode
    str <- hGetContents h1
    let parsed = pStructs $ rmLn str
    hPutStr h2 $ either show pp parsed
    hPutStr h2 $ either show pm parsed
    hClose h1
    hClose h2
    -- (putStrLn . either show pp . pStruct . rmLn) str
    -- putStrLn $ show $ pStructs $ rmLn str

pm :: [StructEntity] -> String
pm [] = ""
pm (x:xs) = softtab 1
    ++ ", data "
    ++ upHead (sname x)
    ++ "(..)"
    ++ nline
    ++ pm xs

rmLn :: String -> String
rmLn str = map (\x -> if x == '\n' || x == '\t' then ' ' else x) str

-- -- -- -- -- -- -- -- -- --

pStructs :: String -> Either ParseError [StructEntity]
pStructs = parse (many pStructEntity) ""

pStruct :: String -> Either ParseError StructEntity
pStruct = parse pStructEntity ""
--
pStructEntity :: Parsec String st StructEntity
pStructEntity = do
    spaces
    sname <- pStructName
    spaces
    sf <- many1 pFieldEntity
    manyTill anyChar (try $ do{ char '}'; spaces; optional (string sname); char ';' })
    spaces
    return (StructEntity sname sf)
--
pStructName :: Parsec String st String
pStructName = do
    optional (string "typedef")
    -- string "typedef"
    spaces
    string "struct"
    spaces
    s <- many letter
    spaces
    string "{"
    return s
--
pFieldEntity :: Parsec String st FieldEntity
pFieldEntity = do
    spaces
    optional (try $ string "const")
    spaces
    ty <- pFTypEntity
    spaces
    optional (try $ string "const")
    spaces
    name <- (many1 letter)
    spaces
    char ';'
    spaces
    mcomm <- optionMaybe pComm
    -- traceShow "mcomm" spaces
    -- traceShow mcomm spaces
    spaces
    return $ FieldEntity name ty mcomm
--


--

pFunctionEntity :: Parsec String st FunctionEntity
pFunctionEntity = do
    mcomm <- optionMaybe pComm
    spaces
    ret <- pFTypEntity
    spaces
    fname <- many1 $ choice [letter, char '_']
    spaces
    argts <- between (char '(') (string ");") (many1 (do{x<-pFTypEntity;spaces;optional (char ',');spaces;return x}))
    spaces
    return (FunctionEntity fname ret argts mcomm)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
