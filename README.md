# Homework 7. SMTLIB

Author: Youngseok Choi

## Problem 1.

```c
/* max() should return a bigger value between a and b if a!=b. 
If a==b, max() should return the value of b*/
int max(int a, int b) {
    int bigger=0;
    if(a >= b + 1) bigger = a;
    else bigger= b; 
    return bigger;
}
```

### 1.1. Write down a proper assert statement to check the correctness of max()

```c
int max(int a, int b) {
    int bigger=0;
    if(a >= b + 1) bigger = a;
    else bigger= b; 
    if (a != b){
        assert(
            ((b > a) && (bigger == b)) || 
            ((a > b) && (bigger == a))
        );
    } else {
        assert(bigger == b);
    }
    return bigger;
}
```

### 1.2. Transform max() into a SSA form and write down the SSA form.

```c
int max(int a, int b) {
    int bigger0 = 0;
    int bigger1;
    if (a >= b + 1) {
        bigger1 = a;
    } else {
        bigger1 = b;
    }
    if (a != b){
        assert(
            ((b > a) && (bigger1 == b)) || 
            ((a > b) && (bigger1 == a))
        );
    } else {
        assert(bigger1 == b);
    }
    return bigger1;
}
```


### 1.3. Write down a corresponding QF_LIA specification and check the correctness 
by using a Z3 SMT solver. Also, provide the Z3 result.
(note. you should show validity, not satisfiability for software verification)

```smt
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
```

Z3 returned `unsat`. It means that there is no counterexample that invalidates the assertion statements,
 thus `max()` is correct.

### 1.4. Write down a corresponding QF_BV and check the correctness by using a Z3 SMT solver. Also, provide the Z3 result.

```
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

```

Z3 returned SAT, which means the assertion can be false for some inputs.

```
sat
b -> #x7fffffff
a -> #x80000000
bigger1 -> #x80000000
bigger0 -> #x00000000
```


### 1.5. Compare the result of 2.3 and 2.4. Why are the results different?

Integer in QF_LIA cannot consider interger overflow because it is following integer axioms in mathematics, 
however QF_BV considers integer overflow. For QF_BV, to show the satisfiablity, z3 used value b as 0x7fffffff, 
which is the bit representation of the largest 32-bit integer, and a as 0x80000000, the bit representation of 
the smallest 32-bit integer. Then we have a >= b+1 is true, so bigger1 is assigned as 0x8000000. However, 
b > a is also true and bigger1 = b does not hold, breaking the asserted condition.

## Problem 2. 

Transform the following sort program into QF_AUFLIA specification and 
write down that QF_AUFLIA specification. Also, check and report the 
correctness by using a Z3 SMT solver (20 pts).
```c
#define N 3
int main(){
    // local variables are initialized with random values
    int data[N], i, j, tmp;
    for (i=0; i<N-1; i++)
        for (j=i+1; j<N; j++) 
            if (data[i] > data[j]) {
                tmp = data[i];
                data[i] = data[j];
                data[j] = tmp;
            }
    
    assert(data[0] <= data[1] && data[1] <= data[2]);
```

Refer `problem2_qf_autlia.smt` file for whole SMT code. Z3 solver gives UNSAT, so assertion is valid on QF_AUFLIA logic.
