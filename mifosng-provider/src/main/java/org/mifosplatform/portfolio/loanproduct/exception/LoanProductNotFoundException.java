/**
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/.
 */
package org.mifosplatform.portfolio.loanproduct.exception;

import org.mifosplatform.infrastructure.core.exception.AbstractPlatformResourceNotFoundException;

/**
 * A {@link RuntimeException} thrown when loan product resources are not found.
 */
public class LoanProductNotFoundException extends AbstractPlatformResourceNotFoundException {

	public LoanProductNotFoundException(Long id) {
		super("error.msg.loanproduct.id.invalid", "Loan product with identifier " + id + " does not exist", id);
	}
}