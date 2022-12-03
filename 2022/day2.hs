import System.IO
import Data.List
import Data.Ord
import Data.Char (isSpace)

main = do
  fileLines <- readLines "day2-input.txt"
  let totalScore = sum [score . calcRound . readPlay $ l | l <- fileLines]
  putStrLn $ "Score: " ++ show totalScore

data HandShape = Rock | Paper | Scissors deriving (Eq, Read, Show, Bounded, Enum)

instance Ord HandShape where
  (<=) x y = x == y || (x, y) `elem` [(Rock, Paper), (Paper, Scissors), (Scissors, Rock)]

data Round = Round { opponent :: HandShape
             , self :: HandShape
             , outcome :: Outcome
             } deriving (Show) 

data Outcome = Win | Tie | Loss deriving (Eq, Ord, Read, Show, Bounded, Enum)

nextShape Scissors = Rock
nextShape t = succ t

prevShape Rock = Scissors
prevShape t = pred t

readOutcome :: String -> Outcome
readOutcome s
  | s == "X" = Loss
  | s == "Y" = Tie
  | s == "Z" = Win

readOpponentHandShape :: String -> HandShape
readOpponentHandShape s
  | s == "A" = Rock
  | s == "B" = Paper
  | s == "C" = Scissors

score :: Round -> Int
score r = scoreHandShape (self r) + scoreOutcome (outcome r)

scoreHandShape s = case s of Rock -> 1
                             Paper -> 2
                             Scissors -> 3

scoreOutcome o = case o of Win -> 6
                           Tie -> 3
                           Loss -> 0

calcRound :: (HandShape, Outcome) -> Round
calcRound (opponent, outcome) = Round opponent (requiredPlay opponent outcome) outcome 

requiredPlay :: HandShape -> Outcome -> HandShape
requiredPlay opponent outcome = case outcome of Win -> nextShape opponent
                                                Tie -> opponent
                                                Loss -> prevShape opponent

readPlay :: String -> (HandShape, Outcome)
readPlay s = (readOpponentHandShape . head $ w, readOutcome . last $ w)
  where
    w = words s

readLines :: FilePath -> IO [String] 
readLines = fmap lines . readFile
