/**
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/.
 */
package org.mifosplatform.portfolio.client.command;

/**
 * Immutable command used for create or update of notes.
 */
public class NoteCommand {

    private final Long id;
    private final Long clientId;
    private final Long loanId;
    private final Long loanTransactionId;
    private final String note;

    public NoteCommand(final Long id, Long clientId, final String note) {
        this.id = id;
        this.clientId = clientId;
        this.loanId = null;
        this.loanTransactionId = null;
        this.note = note;
    }

    public Long getId() {
        return id;
    }

    public Long getClientId() {
        return clientId;
    }

    public Long getLoanId() {
        return loanId;
    }

    public Long getLoanTransactionId() {
        return loanTransactionId;
    }

    public String getNote() {
        return note;
    }
}