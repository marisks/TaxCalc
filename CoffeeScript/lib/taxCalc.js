(function() {
  var rules, sys, taxCalcRecI;

  sys = require('sys');

  rules = [
    {
      income: 0,
      taxPerc: 0.10
    }, {
      income: 5070,
      taxPerc: 0.14
    }, {
      income: 8660,
      taxPerc: 0.23
    }
  ];

  exports.taxCalcProc = function(income) {
    var prevAmount, prevRule, rule, tax, _i, _len;
    tax = 0;
    prevRule = {
      income: 0,
      taxPerc: 0.0
    };
    for (_i = 0, _len = rules.length; _i < _len; _i++) {
      rule = rules[_i];
      if (income > rule.income) {
        prevAmount = rule.income - prevRule.income;
        tax += prevAmount * prevRule.taxPerc;
      } else {
        tax += (income - prevRule.income) * prevRule.taxPerc;
        return tax;
      }
      prevRule = rule;
    }
    tax += (income - prevRule.income) * prevRule.taxPerc;
    return tax;
  };

  taxCalcRecI = function(income, prevRule, cutRules) {
    var curRule, curTax;
    if (cutRules.length === 0) {
      curTax = (income - prevRule.income) * prevRule.taxPerc;
      return curTax;
    }
    curRule = cutRules[0];
    if (income < curRule.income) {
      curTax = (income - prevRule.income) * prevRule.taxPerc;
      return curTax;
    }
    curTax = (curRule.income - prevRule.income) * prevRule.taxPerc;
    curTax += taxCalcRecI(income, curRule, cutRules.slice(1));
    return Math.round(curTax * 100) / 100;
  };

  exports.taxCalcRec = function(income) {
    var prevRule;
    prevRule = rules[0];
    return taxCalcRecI(income, prevRule, rules.slice(1));
  };

}).call(this);
