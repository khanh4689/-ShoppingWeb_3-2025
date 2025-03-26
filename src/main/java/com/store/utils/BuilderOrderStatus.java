package com.store.utils;

import java.util.List;

import org.springframework.stereotype.Component;

import com.store.repository.interfaces.UpdateStatusInterface;
import com.store.web.resp.RespUpdateStatus;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class BuilderOrderStatus {
	
	public List<RespUpdateStatus> respUpdateStatus(List<UpdateStatusInterface> updateStatus) {
		return updateStatus
				.stream()
				.map(this::respUpdateStatus)
				.toList();
	}
	
	public RespUpdateStatus respUpdateStatus(UpdateStatusInterface updateStatus) {
		return RespUpdateStatus
				.builder()
				.id(updateStatus.getId())
				.date(GetString.getDateTime(updateStatus.getDateUpdate()))
				.description(updateStatus.getDescriptions())
				.gmail(updateStatus.getGmail())
				.build();
	}
}
