import System.IO
import Data.List
import Data.Ord

main = do
  fileLines <- readLines "day1-input.txt"
  putStrLn $ "Answer: " ++ (show . sum . topNCalories 3 $ fileLines)

topNCalories :: Int -> [String] -> [Int]
topNCalories x l = take x (sortDesc . calories $ l)

calories :: [String] -> [Int]
calories l
  | null fstGroup && null sndGroup = []
  | null fstGroup = [sum . strToInt . tail $ sndGroup]
  | null sndGroup = [sum . strToInt $ fstGroup]
  | otherwise = [sum . strToInt $ fstGroup] ++ calories (tail sndGroup)
  where
    group = break (=="")l -- Split on the blank lines
    fstGroup = fst group
    sndGroup = snd group

strToInt :: [String] -> [Int]
strToInt = map read

readLines :: FilePath -> IO [String] 
readLines = fmap lines . readFile

sortDesc = sortBy (flip compare)
