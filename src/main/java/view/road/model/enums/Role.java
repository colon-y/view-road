package view.road.model.enums;

import com.fasterxml.jackson.annotation.JsonCreator;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Role {
  
	ROLE_GUEST("ROLE_GUEST", "손님"),
	ROLE_USER("ROLE_USER", "일반사용자"),
	ROLE_MANAGER("ROLE_MANAGER", "중간관리자"),
	ROLE_ADMIN("ROLE_ADMIN", "최고관리자");

    private final String key;
    private final String title;

    
    @JsonCreator
    public static Role getEnumFromValue(String value) {
    	try {
              	return Role.valueOf(value);
         	 } catch (Exception e) {
              	return null;
         	 }
    }
    
}
