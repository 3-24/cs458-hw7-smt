(benchmark example
:status sat
:logic QF_BV
:extrafuns ((a BitVec[32])
    (b BitVec[32])
    (bigger1 BitVec[32])
    (bigger0 BitVec[32])
)
:formula (
    and
    (= bigger0 bv0[32])
    (or
        (and (bvsge a (bvadd b bv1[32])) (= bigger1 a))
        (and (not (bvsge a (bvadd b bv1[32]))) (= bigger1 b))
    )
    (not (or
        (and (= a b) (= bigger1 b))
        (and (not (= a b))
            (or
                (and (bvsgt b a) (= bigger1 b))
                (and (bvsgt a b) (= bigger1 a))
            )
        )
    ))
)
