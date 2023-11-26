import { render, screen } from '@testing-library/react';
import Home from './Home';

test('renders the home page content', () => {
  render(<Home />);

  expect(screen.getByTestId("home-sub-title")).toHaveTextContent("This is a React component");
});
