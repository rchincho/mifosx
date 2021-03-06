/**
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/.
 */
package org.mifosplatform.infrastructure.dataqueries.service;

import javax.sql.rowset.CachedRowSet;

import org.mifosplatform.infrastructure.dataqueries.data.GenericResultsetData;

public interface GenericDataService {

    CachedRowSet getCachedResultSet(String sql, String errorMsg);

    void updateSQL(String sql, String sqlErrorMsg);

    GenericResultsetData fillGenericResultSet(final String sql);

    String generateJsonFromGenericResultsetData(GenericResultsetData grs);

    String replace(String str, String pattern, String replace);

    String wrapSQL(String sql);

    String getDatabaseName();

}