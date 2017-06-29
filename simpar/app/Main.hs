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
    let s = parse parseMagics "" (rmLn str)
    either print toFile s
    trace "READ done" $ return ()
    -- either print (toFile "s") $ parseStructs $ rmLn str
    -- either print (toFile "f") $ parseFuns $ rmLn str
    hClose h1
    -- (putStrLn . either show pp . pStruct . rmLn) str
    -- putStrLn $ show $ pStructs $ rmLn str
--
--
toFile :: [Magic] -> IO ()
toFile ms = do
    let (ss, fs, cs) = deMagic ms
    h2 <- openFile ("output_s.hsc") WriteMode
    hPutStr h2 $ printHsc ss
    hPutStr h2 "\n\n"
    hPutStr h2 $ printModel_struct ss
    hClose h2
    h3 <- openFile ("output_f.hsc") WriteMode
    hPutStr h3 $ printHsc fs
    hPutStr h3 "\n\n"
    hPutStr h3 $ printHsc cs
    hPutStr h3 "\n\n"
    hPutStr h3 $ printModel_function fs
    hPutStr h3 $ printModel_constant cs
    hClose h3



-- toFileS :: [Magic] -> IO ()
-- toFileS ses = do
--     h2 <- openFile ("output_s.hsc") WriteMode
--     hPutStr h2 $ printHsc ses
--     hPutStr h2 "\n\n"
--     hPutStr h2 $ printModel_struct ses
--     hClose h2
-- --
-- toFileF :: [Magic] -> IO ()
-- toFileF ses = do
--     h2 <- openFile ("output_f.hsc") WriteMode
--     hPutStr h2 $ printHsc ses
--     hPutStr h2 "\n\n"
--     hPutStr h2 $ printModel_function ses
--     hClose h2
-- --
--
-- --
-- parseStructs :: String -> Either ParseError [StructEntity]
-- parseStructs = parse (many (do {
--     spaces;
--     x <- parseStructEntity;
--     spaces; return x
--     })) ""
-- --
-- parseFuns :: String -> Either ParseError [FunctionEntity]
-- parseFuns = parse (many (do {spaces; x <- parseFunctionEntity; spaces; return x})) ""
--
rmLn :: String -> String
rmLn str = map (\x -> if x == '\n' || x == '\t' then ' ' else x) str
--
-- -- -- -- -- -- -- -- -- --
-- void spCurveTimeline_setStepped (spCurveTimeline* self, int frameIndex);
-- float spCurveTimeline_getCurvePercent (const spCurveTimeline* self, int frameIndex, float percent);
--
