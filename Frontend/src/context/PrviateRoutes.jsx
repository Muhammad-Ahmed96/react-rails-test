import { Navigate, Outlet } from 'react-router-dom';
import { AuthContext } from './authContext';
import { useContext } from 'react';


export default function PrivateRoutes() {
  const { token } = useContext(AuthContext);

  return token ? <Outlet /> : <Navigate to="/login" replace />;
}
