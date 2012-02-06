sys = require('sys')
rules = [{income: 0, taxPerc: 0.10}, {income: 5070, taxPerc: 0.14}, {income: 8660, taxPerc: 0.23}]

exports.taxCalcProc = (income) ->
  tax = 0
  prevRule = {income:0, taxPerc: 0.0}
  for rule in rules
    if income > rule.income
      prevAmount = rule.income - prevRule.income
      tax += prevAmount * prevRule.taxPerc
    else
      tax += (income - prevRule.income) * prevRule.taxPerc
      return tax
    prevRule = rule
  tax += (income - prevRule.income) * prevRule.taxPerc
  tax

taxCalcRecI = (income, prevRule, cutRules) ->
  if cutRules.length is 0
    curTax = (income - prevRule.income)*prevRule.taxPerc
    return curTax
  curRule = cutRules[0]
  if income<curRule.income
    curTax = (income - prevRule.income)*prevRule.taxPerc
    return curTax

  curTax = (curRule.income - prevRule.income)*prevRule.taxPerc
  curTax += taxCalcRecI(income, curRule, cutRules.slice(1))
  Math.round(curTax*100)/100
exports.taxCalcRec = (income) ->
  prevRule= rules[0]
  taxCalcRecI(income, prevRule, rules.slice(1))
