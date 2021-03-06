/**
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/.
 */
package org.mifosplatform.portfolio.savingsaccount.command;

import java.util.ArrayList;
import java.util.List;

import org.mifosplatform.infrastructure.core.data.ApiParameterError;
import org.mifosplatform.infrastructure.core.data.DataValidatorBuilder;
import org.mifosplatform.infrastructure.core.exception.PlatformApiDataValidationException;

public class SavingAccountStateTransitionCommandValidator {
	
	private final SavingStateTransitionsCommand command;
	
	public SavingAccountStateTransitionCommandValidator(final SavingStateTransitionsCommand command) {
		this.command = command;
	}
	
	public void validate() {

        List<ApiParameterError> dataValidationErrors = new ArrayList<ApiParameterError>();
        DataValidatorBuilder baseDataValidator = new DataValidatorBuilder(dataValidationErrors).resource("saving.account.transition");
        baseDataValidator.reset().parameter("accountId").value(command.getAccountId()).notNull().integerGreaterThanZero();
        baseDataValidator.reset().parameter("eventDate").value(command.getEventDate()).notNull();
        baseDataValidator.reset().parameter("note").value(command.getNote()).notNull();

        if (!dataValidationErrors.isEmpty()) { throw new PlatformApiDataValidationException("validation.msg.validation.errors.exist",
                "Validation errors exist.", dataValidationErrors); }
    }

}
