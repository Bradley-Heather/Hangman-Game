module Main where

import Control.Monad (forever)
import Data.Char     (toLower)
import Data.Maybe    (isJust)
import Data.List     (intersperse)
import System.Exit   (exitSuccess)
import System.IO     (BufferMode(NoBuffering), hSetBuffering, stdout)
import System.Random (randomRIO)

main :: IO ()
main = do
  putStrLn "hello world"

type WordList = [String]

allWords :: IO WordList
allWords = do 
  dict <- readFile "data/dict.txt"
  return (lines dict)

minWordLength :: Int
minWordLength = 5

maxWordLength :: Int
maxWordLength = 9 

gameWords = do 
  aw <- allWords
  return (filter gameLength aw)
  where gameLength w =
         let l = length (w :: String)
         in l >= minWordLength && l < maxWordLength

randomWord :: WordList -> IO String
randomWord wl = do 
  randomIndex <- randomRIO (0, (Length gameWords - 1))
  return $ wl !! randomIndex

randomWord' :: IO String
randomWord' = gameWords >>= randomWord

data Puzzle = Puzzle String [Maybe Char] [Char] -- The word we trying to guess, the characters we've filled in and the letters we've guessed 

instance Show Puzzle where 
  show (Puzzle _ discovered guessed) = (intersperse ' ' $ fmap renderPuzzleChar discovered) ++ " Guessed so far: " ++ guessed

freshPuzzle :: String -> Puzzle 
freshPuzzle n = undefined 

