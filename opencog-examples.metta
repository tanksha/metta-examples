;; MeTTa implementation of pattern matching example from OpenCog classic

;; The choice example
;; https://github.com/opencog/atomspace/blob/master/examples/pattern-matcher/choice.scm 

(: hasColor (-> $a $b Bool))
(hasColor banana yellow)
(hasColor strawberry red)
(hasColor apple green)

;; Look for fruit that is red or green.

;; Pattern matching

(= (choice) red)
(= (choice) green)

!(assertEqualToResult
(match &self (, (hasColor $x $cl) (= (choice) $cl)) $x)
(strawberry apple))

;; Universal quantifier (for-all) example 
https://github.com/opencog/atomspace/blob/master/examples/pattern-matcher/always.scm

(member redBall redsBasket)
(member redBallToo redsBasket)
(member redBallAlso redsBasket)

(member aRedBall anotherRedBasket)
(member bRedBall anotherRedBasket)
(member redBallAlso anotherRedBasket)

(member redBall redsAndgreensBasket)
(member redBallToo redsAndgreensBasket)
(member greenBall redsAndgreensBasket)

(member yellowBall yellowsBasket)
(member ochreBall yellowsBasket)

(hasColor redBall red)
(hasColor redBallToo red)
(hasColor redBallAlso red)
(hasColor aRedBall red)
(hasColor bRedBall red)

(hasColor greenBall green)

(hasColor yellowBall yellow)
(hasColor ochreBall yellow)

;; Report the basket which has ONLY red_ball's.

(= (others) green)
(= (others) yellow)

(: if (-> Bool $a $a $a))
(= (if True $x $y) $x)
(= (if False $x $y) $y)

(= (filter (multicolor $a) $b) (if (== $a $b) () $b))

!(assertEqualToResult
(match &self (,(member $b $bs) (hasColor $b red))
    (match &self (, (member $bl $bs) (hasColor $bl $cl) (=(others) $cl))
        (filter (multicolor $bs) (match &self (,(member $bb $bss) (hasColor $bb red)) $bss))))
(redsBasket redsBasket redsBasket anotherRedBasket anotherRedBasket anotherRedBasket () () redsBasket redsBasket redsBasket anotherRedBasket anotherRedBasket anotherRedBasket () ()))
