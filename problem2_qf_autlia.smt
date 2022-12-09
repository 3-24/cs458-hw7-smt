(benchmark example
:status sat
:logic QF_AUTLIA
:extrafuns (
    (data_0 Array)
    (data_1 Array)
    (data_2 Array)
    (data_3 Array)
    (data_4 Array)
    (data_5 Array)
    (data_6 Array)
    (data_7 Array)
    (data_8 Array)
    (data_9 Array)
    (i_0 Int)
    (i_1 Int)
    (j_0 Int)
    (j_1 Int)
    (j_2 Int)
    (tmp_0 Int)
    (tmp_1 Int)
    (tmp_2 Int)
)

:assumption (= i_0 0)
:assumption(= j_0 1)
:assumption (= tmp_0 (select data_0 i_0))
:assumption (= data_1 (store data_0 i_0 (select data_0 j_0)))
:assumption (= data_2 (store data_1 j_0 tmp_0))
:assumption (= data_3 (if_then_else
    (> (select data_0 i_0) (select data_0 j_0))
    data_2 data_0
))

:assumption (= j_1 2)
:assumption (= tmp_1 (select data_3 i_0))
:assumption (= data_4 (store data_3 i_0 (select data_3 j_1)))
:assumption (= data_5 (store data_4 j_1 tmp_1))
:assumption (= data_6 (if_then_else
    (> (select data_3 i_0) (select data_3 j_1))
    data_5 data_3
))

:assumption (= i_1 1)
:assumption (= j_2 2)
:assumption (= tmp_2 (select data_6 i_1))
:assumption (= data_7 (store data_6 i_1 (select data_6 j_2)))
:assumption (= data_8 (store data_7 j_2 tmp_2))
:assumption (= data_9 (if_then_else
    (> (select data_6 i_1) (select data_6 j_2))
    data_8 data_6
))




:formula (not (and
    (<= (select data_9 0) (select data_9 1))
    (<= (select data_9 1) (select data_9 2))
))
