package com.store.repository.interfaces;

import java.time.LocalDateTime;

public interface UpdateStatusInterface {
	Integer getId();
	String getGmail();
	LocalDateTime getDateUpdate();
	String getDescriptions();
}
