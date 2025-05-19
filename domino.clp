(deffacts init
    (helyezett 1)
    (helyezett 2)
    (helyezett 3)
    (helyezett 4)
    (helyezett 5)

    (forename amalia cecilia emilia otilia rozalia)
    (surname dombos gombos kabos lombos zabos)
    (klub anyokak mamikak nagyiklub oregnenek sztarklub)
)

(defrule solve
;Gombos jobb helyezést ért el,
;mint Cecilia és mint a Sztár-Klub versenyzője,
;de rosszabbat, mint zabos.
    (helyezett ?GOMBOS)
    (helyezett ?CECILIA)
    (helyezett ?SZTARKLUB)
    (helyezett ?ZABOS&~?GOMBOS)
    (test
        (
            and (< ?GOMBOS ?CECILIA)
                (< ?GOMBOS ?SZTARKLUB)
                (> ?GOMBOS ?ZABOS)
                
        )
    )
    (test
        (
            ; Vagy cecilia van előbb mint sztarklub, vagy forditva
            or  (< ?CECILIA ?SZTARKLUB)
                (< ?SZTARKLUB ?CECILIA)
        )
    )
    ;Az Anyókák képviselője közvetlenül Emilia előtt végzett,
    ;aki közvetlenül Dombos előtt végzett a bajnokságon.
    (helyezett ?ANYOKAK&~?SZTARKLUB)
    (helyezett ?EMILIA&~?CECILIA)
    (helyezett ?DOMBOS&~?ZABOS&~?GOMBOS)
    (
        test (
            and (= (- ?ANYOKAK ?EMILIA) -1)
                (= (- ?EMILIA ?DOMBOS) -1)
            )
    )
    ; Rozália nem a Nagyi-Klub tagja
    (helyezett ?NAGYIKLUB&~?SZTARKLUB&~?ANYOKAK)
    (helyezett ?ROZALIA&~?CECILIA&~?EMILIA&~?NAGYIKLUB)

    ; Lombos valahol Amália előtt, aki valahol az Öreg Nénék versenyzője előtt végzett
    (helyezett ?LOMBOS&~?DOMBOS&~?ZABOS&~?GOMBOS)
    (helyezett ?AMALIA&~?ROZALIA&~?EMILIA&~?CECILIA)
    (helyezett ?OREGNENEK&~?SZTARKLUB&~?NAGYIKLUB&~?ANYOKAK)
    (test
        (
            and (< ?LOMBOS ?AMALIA)
                (< ?AMALIA ?OREGNENEK)
        )
    )
    ; Kabos keresztneve nem Cecilia és nem Rozália
    (helyezett ?KABOS&~?LOMBOS&~?DOMBOS&~?ZABOS&~?GOMBOS&~?CECILIA&~?ROZALIA)
    
    ; Lombos keresztneve nem Emilia.
    (helyezett ?LOMBOS&~?EMILIA)
    
    ; Gombos nem az Öreg Nénék képviseletében játszott.
    (helyezett ?GOMBOS&~?OREGNENEK)

    ; Emilia nem a Sztár-Klub tagja.
    (helyezett ?EMILIA&~?SZTARKLUB)
    (helyezett ?OTILIA&~?AMALIA&~?ROZALIA&~?EMILIA&~?CECILIA)
    (helyezett ?MAMIKAK&~?OREGNENEK&~?SZTARKLUB&~?NAGYIKLUB&~?ANYOKAK)
    =>
    (assert
        (solution
            amalia ?AMALIA cecilia ?CECILIA emilia ?EMILIA otilia ?OTILIA rozalia ?ROZALIA
            dombos ?DOMBOS gombos ?GOMBOS kabos ?KABOS lombos ?LOMBOS zabos ?ZABOS
            anyokak ?ANYOKAK mamikak ?MAMIKAK nagyiklub ?NAGYIKLUB oregnenek ?OREGNENEK sztarklub ?SZTARKLUB
        )
    )
)