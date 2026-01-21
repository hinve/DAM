import { Component, OnInit } from '@angular/core';
import packageInfo from '../../../../package.json';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.scss']
})
export class FooterComponent implements OnInit {

  yyyy: number;
  version: string = packageInfo.version;

  constructor() { }

  ngOnInit() {
    this.yyyy = new Date().getFullYear();
  }

}
