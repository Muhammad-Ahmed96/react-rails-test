
const API_URL = 'http://localhost:3000'

export async function getProjects() {
  const token = localStorage.getItem('token');

  const response = await fetch(`${API_URL}/admin/projects`, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
      }
    })
  if(!response.ok) {
    throw new Error("Something went wrong")
  }

  const data = await response.json()
  return data;
}

export async function getProject(id) {
  const token = localStorage.getItem('token');
  const response = await fetch(`${API_URL}/projects/${id}`, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    }
  });
  if (!response.ok) {
    throw new Error('Failed to fetch project');
  }
  const data = await response.json();
  return data;
}

export async function getAssignedProjects() {
    const token = localStorage.getItem('token');

  const response = await fetch(`${API_URL}/projects`, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
      }
    })
  if(!response.ok) {
    throw new Error("Something went wrong")
  }

  const data = await response.json()
  return data;
}