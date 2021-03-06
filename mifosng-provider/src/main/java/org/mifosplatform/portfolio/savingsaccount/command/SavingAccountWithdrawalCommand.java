/**
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/.
 */
package org.mifosplatform.portfolio.savingsaccount.command;

import java.math.BigDecimal;

import org.joda.time.LocalDate;

public class SavingAccountWithdrawalCommand {
	
	private final Long accountId;
	private final LocalDate transactionDate;
	private final BigDecimal amount;
	private final String note;
	
	public SavingAccountWithdrawalCommand(final Long accountId, final LocalDate transactionDate, final BigDecimal amount, final String note) {
		this.accountId = accountId;
		this.transactionDate = transactionDate;
		this.amount = amount;
		this.note = note;
	}

	public Long getAccountId() {
		return this.accountId;
	}

	public LocalDate getTransactionDate() {
		return this.transactionDate;
	}

	public BigDecimal getAmount() {
		return this.amount;
	}

	public String getNote() {
		return this.note;
	}
}
