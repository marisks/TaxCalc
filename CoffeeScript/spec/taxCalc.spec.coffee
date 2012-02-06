taxCalc = require('../lib/taxCalc').taxCalcRec

describe 'Tax calculator', ->
  it 'shoud calculate 500 tax for 5000 income', ->
    tax = taxCalc 5000
    expect(500).toEqual tax
  it 'should calculate 609.2 tax for 5800 income', ->
    tax = taxCalc 5800
    expect(609.2).toEqual tax
  it 'should calculate 1087.8 tax for 9000 income', ->
    tax = taxCalc 9000
    expect(1087.8).toEqual tax
