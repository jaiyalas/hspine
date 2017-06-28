module Main where
--
import Simpar
import Simpar.Types
import Simpar.Print
--
import Text.Parsec
import Data.Char
import Data.Either
import System.Environment (getArgs)
import System.IO
import Debug.Trace
--
main :: IO ()
main = do
    xs <- getArgs
    -- h1 <- openFile (head xs) ReadMode
    h1 <- openFile "test.h" ReadMode
    str <- hGetContents h1
    let s = parse parseBoth "" (rmLn str)
    either print toFile_either s
    trace "READ done" $ return ()
    -- either print (toFile "s") $ parseStructs $ rmLn str
    -- either print (toFile "f") $ parseFuns $ rmLn str
    hClose h1
    -- (putStrLn . either show pp . pStruct . rmLn) str
    -- putStrLn $ show $ pStructs $ rmLn str
--

-- typedef struct spBaseTimeline spRotateTimeline;
--
toFile_either :: (PrintHsc a, PrintHsc b) => [Either a b] -> IO ()
toFile_either e = do
    toFile "s" (lefts e)
    toFile "f" (rights e)
--
toFile :: PrintHsc a => String -> [a] -> IO ()
toFile s ses = do
    h2 <- openFile ("output_"++s++".hsc") WriteMode
    hPutStr h2 $ printHsc ses
    -- hPutStr h2 $ pm ses
    hClose h2
--
parseBoth :: Parsec String st [Either StructEntity FunctionEntity]
parseBoth = many (try parseRightFunc <|> try parseLeftStruct)
--
spsf :: (a -> b) -> Parsec String st a -> Parsec String st b
spsf f p = do
    spaces
    x <- p
    spaces
    return (f x)
--
parseRightFunc = spsf Right parseFunctionEntity
parseLeftStruct = spsf Left parseStructEntity
--
parseStructs :: String -> Either ParseError [StructEntity]
parseStructs = parse (many (do {
    spaces;
    x <- parseStructEntity;
    spaces; return x
    })) ""
--
parseFuns :: String -> Either ParseError [FunctionEntity]
parseFuns = parse (many (do {spaces; x <- parseFunctionEntity; spaces; return x})) ""
--
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
-- void spCurveTimeline_setStepped (spCurveTimeline* self, int frameIndex);
-- float spCurveTimeline_getCurvePercent (const spCurveTimeline* self, int frameIndex, float percent);
--
