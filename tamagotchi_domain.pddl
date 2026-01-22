(define (domain tama)

    (:requirements :equality :negative-preconditions :typing :adl :fluents)

    (:types
        tamagotchi - object
        loc - object
    )

    (:constants
        bed kitchen - loc
    )

    (:predicates
        ; tamagotchi is alive
        (alive ?t - tamagotchi)
        (at ?t - tamagotchi ?loc -loc)
        (sleep-mode ?t - tamagotchi)
        (feed-mode ?t - tamagotchi)
        (study-mode ?t - tamagotchi)
        (done)
    )

    (:functions
        ; tamagotchi can become more or less hungry, unhappy, healthy, and sleepy over time
        (hunger ?t - tamagotchi)
        (unhappiness ?t - tamagotchi)
        (sleepiness ?t - tamagotchi)

        ; mode countdown value indicating time left before switching modes
        (mode-countdown)

        ; duration that timer resets to before switching modes again
        (mode-duration)

    )

    ; global timer that stays in each mode for ten time steps
    (:process mode-timer
        :parameters ()
        :precondition (>= (mode-countdown) 0)
        :effect (decrease (mode-countdown) #t)
    )

    ; unhappiness increases in a non-linear way at the rate of sleep
    (:process stress-growth
        :parameters (?t - tamagotchi)
        :precondition (and(
            alive ?t)
            )
        :effect (increase (unhappiness ?t) (* #t (sleepiness ?t)))
    )

    ; when global timer hits zero and tamagotchi in feed mode, switch to sleep mode
    (:event mode-change-feed-to-sleep
        :parameters (?t - tamagotchi)
        :precondition (and
            (<= (mode-countdown) 0)
            (feed-mode ?t)
            (not (sleep-mode ?t))
            (not (study-mode ?t))
        )
        :effect (and
            (increase (mode-countdown) (mode-duration))
            (sleep-mode ?t)
            (not (feed-mode ?t))
        )
    )

    ; when global timer hits zero and tamagotchi in sleep mode, switch to feed mode
    (:event mode-change-sleep-to-feed
        :parameters (?t - tamagotchi)
        :precondition (and
            (<= (mode-countdown) 0)
            (sleep-mode ?t)
            (not (feed-mode ?t))
            (not (study-mode ?t))
        )
        :effect (and
            (increase (mode-countdown) (mode-duration))
            (feed-mode ?t)
            (not (sleep-mode ?t))
        )
    )

    ; while tamagotchi sleeps it recovers from sleepiness and unhappiness, but becomes more hungry
    (:process sleep-recovery
        :parameters (?t - tamagotchi)
        :precondition (and (alive ?t) (sleep-mode ?t)
            (at ?t bed)
        )
        :effect (and
            (decrease (sleepiness ?t) #t) 
            (increase (hunger ?t) (* 0.5 #t))
            (decrease (unhappiness ?t) (* 0.1 #t))
            )
    )

    ; while tamagotchi eats, it recovers from hunger and unhappiness, but becomes increasingly sleepy
    (:process feed-recovery
        :parameters (?t - tamagotchi)
        :precondition (and (alive ?t) (feed-mode ?t)
            (at ?t kitchen)
            )
        :effect (and
            (decrease (hunger ?t) #t) 
            (increase (sleepiness ?t) (* 0.5 #t)) 
            (decrease (unhappiness ?t) (* 0.1 #t))
            )
    )

    ; tamagotchi moves to either kitchen to eat or bed to sleep
    (:action move
        :parameters (?t - tamagotchi ?from ?to - loc)
        :precondition (at ?t ?from)
        :effect (and
            (not (at ?t ?from))
            (at ?t ?to)
        )
    )

    ; when tamagotchi is sufficiently fed, well-rested, and happy, end the game
    (:action finish
        :parameters (?t - tamagotchi)
        :precondition (and
            (alive ?t)
            (<= (hunger ?t) 2)
            (<= (sleepiness ?t) 2)
            (<= (unhappiness ?t) 2)
        )
        :effect (done)

    )

)