module Hanoi where

import Diagrams.Backend.Cairo
import Diagrams.Prelude

type DC = Diagram Cairo R2

colors = [blue, green, red, yellow, purple]

type Disk  = Int
type Stack = [Disk]
type Hanoi = [Stack]
type Move  = (Int,Int)

postHeight = 6

renderDisk :: Disk -> DC
renderDisk n = rect (fromIntegral n + 2) 1
               # lc black
               # fc (colors !! n)
               # lw 0.1

renderStack :: Stack -> DC
renderStack s = disks `atop` post
  where disks = (vcat . map renderDisk $ s)
                # alignB
        post  = rect 0.8 postHeight
                # lw 0
                # fc saddlebrown
                # alignB

renderHanoi :: Hanoi -> DC
renderHanoi h = view ((-7) & 0) ((fromIntegral (length h + 1) * 7) & postHeight)
              . hcat' with {catMethod = Distrib, sep = 7}
              . map renderStack
              $ h
