package egovframework.example.worker.mapper;

import java.util.List;

import egovframework.example.worker.vo.WorkerVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("workerMapper")
public interface WorkerMapper {

    List<WorkerVO> workerSelect() throws Exception;

    List<WorkerVO> workerInfoList(String paramString) throws Exception;

    void deleteWorkerInfo(String paramString) throws Exception;

    void insertWorker(WorkerVO paramWorkerVO) throws Exception;

    void updateWorker(WorkerVO paramWorkerVO) throws Exception;

    List<WorkerVO> workerLocationSelect(String paramString) throws Exception;
}
