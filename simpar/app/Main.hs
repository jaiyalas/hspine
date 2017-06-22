module Main where
--
import Lib
--
import Text.Parsec
import Data.Char
import System.Environment (getArgs)
--
main :: IO ()
main =
    getArgs >>=
    (putStrLn . either show pp . pStruct . rmLn . head)



rmLn :: String -> String
rmLn str = filter (/= '\n') str

pStruct :: String -> Either ParseError StructEntity
pStruct = parse pStructEntity ""



data StructEntity = StructEntity
    { sname   :: String
    , sfields :: [FieldEntity]
    } deriving (Eq, Show)
--
data FieldEntity = FieldEntity
    { fieldName :: String
    , fieldType :: FTypEntity
    , fieldComm :: Maybe String
    } deriving (Eq, Show)
--
data FTypEntity = FTypEntity
    { ptrCounter :: Int
    , typeBody :: FTyp
    } deriving (Eq, Show)
--
data FTyp
    = FTInt
    | FTFloat
    | FTVoid
    | FTOther String
    deriving (Eq, Show)
--
class PP a where
    pp :: a -> String
instance PP StructEntity where
    pp (StructEntity cname@(h:xs) sfs) =
        let name = ((toUpper h) : xs)
            fsMount = length sfs
            argNames = take fsMount $ map (\c->[c]) ['a'..'z']
            args = concat $ map (' ':) argNames
            fnames = map fieldName sfs
        in "data "
        ++ name
        ++ " = "
        ++ name
        ++ nline
        ++ softtab 1 ++ "{ "
        ++ (drop 3 $ concat $ map (((softtab 1 ++ ", ")++).(++ nline).pp) sfs)
        ++ softtab 1 ++ "} deriving (Show, Eq)\n"
        --
        ++ "instance Storable " ++ name ++ " where"
        ++ nline
        ++ softtab 1 ++ "alignment _ = #{alignment " ++ cname ++ "}"
        ++ nline
        ++ softtab 1 ++ "sizeOf _    = #{size " ++ cname ++ "}"
        ++ nline
        ++ softtab 1 ++ "peek ptr = do"
        ++ nline
        ++ pls cname (zip argNames fnames)
        ++ softtab 2 ++ "return (" ++ cname ++ args ++ ")"
        ++ nline ++ nline


pls :: String -> [(String, String)] -> String
pls cname ((a,b):xs) =
    softtab 2
    ++ (genPeekLine cname a b)
    ++ nline
    ++ (pls cname xs)
pls cname [] = ""

nline :: String
nline = "\n"

softtab :: Int -> String
softtab 0 = ""
softtab n = "    " ++ softtab (n-1)


genPeekLine :: String -> String -> String -> String
genPeekLine cname argName fname =
    argName ++ " <- #{peek " ++
    cname ++ ", " ++ fname ++ "} ptr"



-- instance Storable SpDrawOrderTimeline where
--     alignment _ = #{alignment spDrawOrderTimeline}
--     sizeOf _    = #{size      spDrawOrderTimeline}
--     peek ptr = do
--         s  <- #{peek spDrawOrderTimeline, super}       ptr
--         fc <- #{peek spDrawOrderTimeline, framesCount} ptr
--         fs <- #{peek spDrawOrderTimeline, frames}      ptr
--         d  <- #{peek spDrawOrderTimeline, drawOrders}  ptr
--         sc <- #{peek spDrawOrderTimeline, slotsCount}  ptr
--         return (SpDrawOrderTimeline s fc fs d sc)
--     poke ptr (SpDrawOrderTimeline s fc fs d sc) = do
--         #{poke spDrawOrderTimeline, super}           ptr s
--         #{poke spDrawOrderTimeline, framesCount}     ptr fc
--         #{poke spDrawOrderTimeline, frames}          ptr fs
--         #{poke spDrawOrderTimeline, drawOrders}      ptr d
--         #{poke spDrawOrderTimeline, slotsCount}      ptr sc




instance PP FieldEntity where
    pp (FieldEntity fname fty (Just comm)) =
        pp (FieldEntity fname fty Nothing) ++
        " -- ^ " ++ comm
    pp (FieldEntity fname fty Nothing) =
        fname ++ " :: " ++ (pp fty)
instance PP FTypEntity where
    pp (FTypEntity 0 ty) = pp ty
    pp (FTypEntity n ty) =
        "Ptr ( " ++ (pp (FTypEntity (n-1) ty)) ++ " )"
instance PP FTyp where
    pp FTInt   = "CInt"
    pp FTFloat = "CFloat"
    pp FTVoid  = "()"
    pp (FTOther (h:xs)) = (toUpper h) : xs
--
pStructEntity :: Parsec String st StructEntity
pStructEntity = do
    spaces
    sname <- pStructName
    spaces
    char '{'
    spaces
    sf <- many1 pFieldEntity
    manyTill anyChar (try $ string $ "} "++sname)
    return (StructEntity sname sf)
--
pStructName :: Parsec String st String
pStructName = do
    string "typedef"
    spaces
    string "struct"
    spaces
    many letter
--
pFieldEntity :: Parsec String st FieldEntity
pFieldEntity = do
    spaces
    _ <- optionMaybe (string "const")
    spaces
    ty <- pFTypEntity
    spaces
    _ <- optionMaybe (string "const")
    spaces
    name <- (many1 letter)
    spaces
    char ';'
    spaces
    mcomm <- optionMaybe pComm
    spaces
    return $ FieldEntity name ty mcomm
--
pComm :: Parsec String st String
pComm = do
    choice [string "/* ", string "/*"]
    spaces
    s <- manyTill anyChar (try (choice [string " */", string "*/"]))
    spaces
    return s
--
pFTypEntity :: Parsec String st FTypEntity
pFTypEntity = do
    p1 <- many (char '*')
    spaces
    t <- choice [pFTInt, pFTFloat, pFTVoid, pFTOther]
    spaces
    p2 <- many (char '*')
    return $ FTypEntity (length p1 + length p2) t
--
pFTInt :: Parsec String st FTyp
pFTInt = string "int" >> return FTInt
--
pFTFloat :: Parsec String st FTyp
pFTFloat = string "float" >> return FTFloat
--
pFTVoid :: Parsec String st FTyp
pFTVoid = string "void" >> return FTVoid
--
pFTOther :: Parsec String st FTyp
pFTOther = do
    spaces
    tname <- (many1 letter)
    spaces
    return (FTOther tname)
--
ss = "typedef struct spPathConstraintSpacingTimeline { spCurveTimeline super; int const framesCount; float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */ int pathConstraintIndex; #ifdef __cplusplus spPathConstraintSpacingTimeline() : super(), framesCount(0), frames(0), pathConstraintIndex(0) { } #endif } spPathConstraintSpacingTimeline;"
