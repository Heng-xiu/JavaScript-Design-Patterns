"use strict"

# ==============================
# ABSTRACT FINANCIAL ENTITY
# ==============================

class FinancialEntity
    constructor: ->
        throw new Error "You cannot instantiate an abstract class!" if @constructor is FinancialEntity

    withdrawMoney: ->
        throw new Error "You cannot call an abstract method!"

# ==============================
# CONCRETE BANK ACCOUNT
# ==============================

class BankAccount extends FinancialEntity
    withdrawMoney: ->
        "Enjoy the cash!"

# ==============================
# CONCRETE ATM 
# ==============================

class ATM extends FinancialEntity
    constructor: (@_bankAccount) ->

    withdrawMoney: (code) ->
        throw type: "AuthenticationException", message: "Invalid code" if code isnt 1337
        @_bankAccount.withdrawMoney()

# ==============================
# CLIENT CODE
# ==============================

bankAccount = new BankAccount
proxy = new ATM bankAccount

try
    console.log proxy.withdrawMoney 1234 # Wrong code
catch e
    console.log "#{e.type} - #{e.message}" # AuthenticationException - Invalid code
finally
    console.log proxy.withdrawMoney 1337 # Enjoy the cash!
