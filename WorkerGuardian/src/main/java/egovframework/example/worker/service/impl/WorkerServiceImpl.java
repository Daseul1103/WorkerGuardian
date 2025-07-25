package egovframework.example.worker.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import egovframework.example.worker.mapper.WorkerMapper;
import egovframework.example.worker.service.WorkerService;
import egovframework.example.worker.vo.WorkerVO;

@Service("workerService")
@Transactional
public class WorkerServiceImpl implements WorkerService {

    @Resource(name = "workerMapper")
    private WorkerMapper workerMapper;

    @Override
    public List<WorkerVO> workerSelect() throws Exception {
        return workerMapper.workerSelect();
    }

    @Override
    public List<WorkerVO> workerInfoList(String workerId) throws Exception {
        return workerMapper.workerInfoList(workerId);
    }

    @Override
    public void deleteWorkerInfo(String workerId) throws Exception {
        workerMapper.deleteWorkerInfo(workerId);
    }

    @Override
    public void insertWorker(WorkerVO vo) throws Exception {
        workerMapper.insertWorker(vo);
    }

    @Override
    public void updateWorker(WorkerVO vo) throws Exception {
        workerMapper.updateWorker(vo);
    }

    @Override
    public List<WorkerVO> workerLocationSelect(String workerId) throws Exception {
        return workerMapper.workerLocationSelect(workerId);
    }
}
