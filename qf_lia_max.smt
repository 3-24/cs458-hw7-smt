(benchmark example
:status sat
:logic QF_LIA
:extrafuns ((a Int)
    (b Int)
    (bigger1 Int)
    (bigger0 Int)
)
:formula (and
    (= bigger0 0)
    (or
        (and (>= a (+ b 1)) (= bigger1 a))
        (and (not (>= a (+ b 1))) (= bigger1 b))
    )
    (not (or
        (and (= a b) (= bigger1 b))
        (and (not (= a b))
            (or
                (and (> b a) (= bigger1 b))
                (and (> a b) (= bigger1 a))
            )
        )
    ))
)
