package egovframework.example.gas.vo;

/*************************************
* 가스 센서 관리 테이블 - gas_info         *
*************************************/
public class GasVO {

    public String GAS_ID;           // 가스 센서 id
    public String GAS_COMPANY;      // 가스 센서 업체
    public String GAS_TYPE;         // 가스 센서 종류
    public String GAS_WORKER_ID;    // 가스 센서 할당 작업자 id
    public String DANGER_PER;       // 가스 위험 농도
    public String GAS_NAME;         // 가스 센서 이름(별칭)
    public String WORKER_NAME;      // 가스 센서 할당 작업자 이름

    public String getGAS_ID() {
        return GAS_ID;
    }

    public void setGAS_ID(String gAS_ID) {
        GAS_ID = gAS_ID;
    }

    public String getGAS_COMPANY() {
        return GAS_COMPANY;
    }

    public void setGAS_COMPANY(String gAS_COMPANY) {
        GAS_COMPANY = gAS_COMPANY;
    }

    public String getGAS_TYPE() {
        return GAS_TYPE;
    }

    public void setGAS_TYPE(String gAS_TYPE) {
        GAS_TYPE = gAS_TYPE;
    }

    public String getGAS_WORKER_ID() {
        return GAS_WORKER_ID;
    }

    public void setGAS_WORKER_ID(String gAS_WORKER_ID) {
        GAS_WORKER_ID = gAS_WORKER_ID;
    }

    public String getDANGER_PER() {
        return DANGER_PER;
    }

    public void setDANGER_PER(String dANGER_PER) {
        DANGER_PER = dANGER_PER;
    }

    public String getGAS_NAME() {
        return GAS_NAME;
    }

    public void setGAS_NAME(String gAS_NAME) {
        GAS_NAME = gAS_NAME;
    }

    public String getWORKER_NAME() {
        return WORKER_NAME;
    }

    public void setWORKER_NAME(String wORKER_NAME) {
        WORKER_NAME = wORKER_NAME;
    }
}
