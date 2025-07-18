import { useContext, useState } from "react";
import { AuthContext } from "../../context/authContext";
import { TaskContext } from "../../context/taskContext";
import { useParams } from "react-router-dom";

export default function AddTask({ toggleAddTask }) {
  const { addTask, fetchProject } = useContext(TaskContext);
  const { id } = useParams();
  const { token } = useContext(AuthContext);
  const [error, setError] = useState(null);

  async function handleSubmit(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    
    const resp = await fetch(`http://localhost:3000/projects/${id}/add-task`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify({task: data})
    })

    const task = await resp.json();

    if(!resp.ok) {
      setError(task.error)
      return;
    }
    addTask(task);

    await fetchProject(id);
    toggleAddTask(false)
  }

  return <div className="card">
    <div className="card-header">
      <h3>Add Task</h3>
    </div>
    <div className="card-body">
      { error && <div class="alert alert-danger">{error}</div> }
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label>Name</label>
          <input type="text"
            name="name"
            className="form-control"
          />
        </div>
        <div className="form-group">
          <label>Description</label>
          <textarea type="text"
            name="description"
            className="form-control"
          />
        </div>
        <div className="form-group">
          <label>Start Time</label>
          <input type="datetime-local"
            name="start_time"
            className="form-control"
          />
        </div>
        <div className="form-group">
          <label>End Time</label>
          <input type="datetime-local"
            name="end_time"
            className="form-control"
          />
        </div>
        <div className="form-group">
          <label>Duration</label>
          <div className="row">
            <div className="col-6">
              <input type="number"
                name="duration"
                className="form-control"
              />
            </div>
            <div className="col-6">
              <select name="duration_type" className="form-control">
                <option value="hours">Hours</option>
                <option value="day">Days</option>
                <option value="weeks">Weeks</option>
                <option value="month">Month</option>
                <option value="years">Years</option>
              </select>
            </div>
          </div>
        </div>
        <div className="mt-3">
          <button type="submit" className="btn btn-sm btn-primary">Submit</button>
        </div>
      </form>
    </div>
  </div>
}