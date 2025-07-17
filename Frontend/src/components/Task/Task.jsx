

import RomanNumerals from 'roman-numerals';

export default function Task({ index, name, duration, start_end }) {
  return <div className="list-group-item">
    <span>
      <span>{RomanNumerals.toRoman(index + 1)}. </span>
      <strong>Task {index + 1}: </strong>
      <span>{name} , </span>
      <span>{duration} </span>
      <span>( {start_end} )</span>
    </span>
  </div>
}