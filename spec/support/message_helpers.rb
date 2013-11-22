module MessageHelpers

  def completed_job(job_id)
    [double('Message', job_id: job_id, action: :start, timestamp: Time.now),
     double('Message', job_id: job_id, action: :finish, timestamp: Time.now)]
  end

  def incompleted_job(job_id)
    [double('Message', job_id: job_id, action: :start, timestamp: Time.now)]
  end

end
