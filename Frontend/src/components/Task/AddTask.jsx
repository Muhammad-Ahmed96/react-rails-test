import { useContext } from "react";
import { AuthContext } from "../../context/authContext";
import { TaskContext } from "../../context/taskContext";
import { useParams } from "react-router-dom";

export default function AddTask({ toggleAddTask }) {
  const { addTask } = useContext(TaskContext);

  const { id } = useParams();
  const { token } = useContext(AuthContext);

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
      body: JSON.stringify(data)
    })

    if(!resp.ok) {
      throw new Error("Failed to save task")
    }

    const task = await resp.json();
    addTask(task);
    toggleAddTask(false)
  }

  return <div className="card">
    <div className="card-header">
      <h3>Add Task</h3>
    </div>
    <div className="card-body">
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
          <input type="number"
            name="duration"
            className="form-control"
          />
        </div>
        <div className="mt-3">
          <button type="submit" className="btn btn-sm btn-primary">Submit</button>
        </div>
      </form>
    </div>
  </div>
}